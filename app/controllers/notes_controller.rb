# frozen_string_literal: true

class NotesController < ApplicationController
  # GET /notes
  def index
    @notes = Note.all
    render formats: :json
  end

  # POST /notes
  def create
    @note = Note.new(note_params)

    if @note.save
      redirect_to @note, notice: 'Note was successfully created.'
    else
      render :new
    end
  end

  private

  def note_params
    params.require(:note).permit(:tag_id, :body)
  end
end
