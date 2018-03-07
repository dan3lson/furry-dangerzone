class School::AddWordsForStudentsController < BaseSchoolController
  def update
    @classroom_names_params = params[:classroom_names]
    @individual_usernames_params = params[:individual_usernames]
    @words = params[:word_ids].split(",").uniq.map { |w| Word.find(w) }
    @tag_name_params = params[:tag_name]
    @students = []

    unless @classroom_names_params.blank?
      @classrooms = @classroom_names_params.map do |c|
        Classroom.find_by(name: c)
      end
      @students << @classrooms.map { |classroom| classroom.students }
    end

    unless @individual_usernames_params.blank?
      @students << @individual_usernames_params.map do |u|
        Student.find_by(username: u)
      end
    end

    unless @tag_name_params.blank?
      @tag = Tag.where(name: @tag_name_params).first_or_initialize
      @tag_msg = if @tag.save
                   "Tag #{@tag.name} successfully saved."
                 else
                   "ERROR: Tag #{@tag.name} not saved."
                 end
    end

    @all_info = []

    @students.flatten.each do |student|
      @info = {}
      @info[student.username] = {}
      @info[student.username][:warnings] = []
      @info[student.username][:successes] = []
      @info[student.username][:errors] = []

      @words.each do |word|
        if student.has_word?(word)
          @info[student.username][:warnings] << word.name

          if @tag
            @user_word = UserWord.object(student, word)
            @user_tag = UserTag.where(teacher: current_user, tag: @tag)
                               .first_or_initialize

            if @user_tag.save
              @user_tag_msg = "Success: UserTag #{@user_tag.id} created."
              @uw_user_tag = @user_tag.user_word_user_tags.where(
                user_tag: @user_tag,
                user_word: @user_word
              ).first_or_initialize
              @uw_user_tag_msg = if @uw_user_tag.save
                                   "Success:"
                                 else
                                   "NOT SAVED: Figure out why lol"
                                 end
            else
              @user_tag_msg = "ERROR: UserTag #{@user_tag.id} not created."
            end
          end
        else
          @user_word = UserWord.new(user: student, word: word)

          if @user_word.save
            @info[student.username][:successes] << word.name

            if @tag
              @user_tag = UserTag.where(teacher: current_user, tag: @tag)
                                 .first_or_initialize

              if @user_tag.save
                @user_tag_msg = "Success: UserTag #{@user_tag.id} created."
                @uw_user_tag = @user_tag.user_word_user_tags.where(
                  user_tag: @user_tag,
                  user_word: @user_word
                ).first_or_initialize
                @uw_user_tag_msg = if @uw_user_tag.save
                                     "Success:"
                                   else
                                     "NOT SAVED: Figure out why lol"
                                   end
              else
                @user_tag_msg = "ERROR: UserTag #{@user_tag.id} not created."
              end
            end
          else
            @info[student.username][:errors] << word.name
          end
        end
      end

      @all_info << @info
    end

    @num_warnings = @num_successes = @num_errors = 0
    @w_strings = []
    @s_strings = []
    @e_strings = []

    @all_info.each do |k, v|
      k.each do |username, v|
        @suc_ary = v[:successes]
        @war_ary = v[:warnings]
        @err_ary = v[:errors]
        @u = "<b>#{username}</b>".html_safe
        @num_successes += @suc_ary.count
        @num_warnings += @war_ary.count
        @num_errors += @err_ary.count

        if @suc_ary.any?
          msg = "#{@u} now has the #{'word'.pluralize(@suc_ary.count)}: "

          @suc_ary.each do |w|
            w == @suc_ary.last ? msg << "#{w}" : msg << "#{w}, "
          end

          @s_strings << msg
        end

        if @war_ary.any?
          msg = "#{@u} already has the #{'word'.pluralize(@war_ary.count)}: "

          @war_ary.each do |w|
            w == @war_ary.last ? msg << "#{w}" : msg << "#{w}, "
          end

          @w_strings << msg
        end

        if @err_ary.any?
          msg = "#{@u} didn\'t previously have these words - and still doesn\'t
            - yikes: "

          @err_ary.each do |w|
            w == @err_ary.last ? msg << "#{w}" : msg << "#{w} , "
          end

          @e_strings << msg
        end
      end
    end

    render json: {
      warnings: @w_strings,
      successes: @s_strings,
      errors: @e_strings,
      num_warnings: @num_warnings,
      num_successes: @num_successes,
      num_errors: @num_errors
    }
  end
end
