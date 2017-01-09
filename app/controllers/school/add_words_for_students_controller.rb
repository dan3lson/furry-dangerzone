class School::AddWordsForStudentsController < BaseSchoolController
  def update
    @students = params[:usernames].map { |s| User.find_by(username: s) }
    @words = params[:word_ids].split(",").uniq.map { |w| Word.find(w) }
    @all_info = []

    @students.each do |s|
      @info = {}
      @info[s.username] = {}
      @info[s.username][:warnings] = []
      @info[s.username][:successes] = []
      @info[s.username][:errors] = []

      @words.each do |w|
        if s.has_word?(w)
          @info[s.username][:warnings] << w.name
        else
          @user_word = UserWord.new(user: s, word: w)

          if @user_word.save
            @info[s.username][:successes] << w.name
          else
            @info[s.username][:errors] << w.name
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
      num_words: @words.count,
      num_students: @students.count,
      num_warnings: @num_warnings,
      num_successes: @num_successes,
      num_successes: @num_successes,
      num_errors: @num_errors
    }
  end

  private
end
