# frozen_string_literal: true

class NotesController < ApplicationController
  # GET /notes
  def index
    @notes = fetch_notes(tag: params[:tag]).includes(:tag)
    render formats: :json
  rescue ActiveRecord::RecordNotFound
    render status: 422, json: {}
  end

  # POST /notes
  def create
    if Note.create_by(tag: post_params[:tag], body: post_params[:body])
      render status: 201, json: { status: :ok }
    else
      render status: 422, json: { status: :error }
    end
  end

  private

  def fetch_notes(tag:)
    return Note.all unless tag

    Tag.find_by!(name: tag).notes
  end

  def post_params
    params.permit(:tag, :body)
  end
end
