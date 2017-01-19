class Admin::MeaningAltsController < BaseAdminController
	def index
    @filter = params[:filter]
		@meaning_alts_count = MeaningAlt.count

    if @filter
      if @filter == "latest"
        @meaning_alts = MeaningAlt.includes(:word, :user)
																	.order("created_at DESC")
																	.paginate(
																		page: params[:page],
																		per_page: 10
																	)
      end
    else
      @meaning_alts = MeaningAlt.includes(:word, :user)
																.order("words.name ASC")
																.paginate(
																	page: params[:page],
																	per_page: 10
																)
    end
  end
end
