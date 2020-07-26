# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Note, type: :model do
  subject { build(:note, tag: tag, body: body).valid? }

  context '正常入力のとき' do
    let(:tag) { create(:tag) }
    let(:body) { 'せいじょう' }

    it { is_expected.to be_truthy }
  end

  context 'tagが空' do
    let(:tag) { nil }
    let(:body) { 'せいじょう' }

    it { is_expected.to be_falsey }
  end

  context 'bodyが空' do
    let(:tag) { create(:tag) }
    let(:body) { nil }

    it { is_expected.to be_falsey }
  end
end
