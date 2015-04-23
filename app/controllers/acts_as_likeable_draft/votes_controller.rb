module ActsAsLikeableDraft
  class VotesController < ::ApplicationController
    # We need session to store votes per likeable_subject
    before_filter :extract_likeable_subject

    def current_votes
      render json: {likes: @likeable_subject.likes, dislikes: @likeable_subject.dislikes}
    end

    def allowed_vote
      render json: {status: @likeable_subject.votes_allowed?(action: vote_action, session: session)}
    end

    def vote
      render json: {status: @likeable_subject.votes_store!(action: vote_action, session: session)}
    end

    protected

    def vote_action
      # filter in routes available vote types
      params[:vote_action].to_sym
    end

    def extract_likeable_subject
      return not_found unless likeable_subjects.includes?(params[:subject_type])
      @likeable_subject = params[:subject_type].classify.find(params[:subject_id])
    end
  end
end
