# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tag, type: :model do
  subject { build(:tag, name: name) }

  context '名前が正常' do
    let(:name) { '強い' }

    it { is_expected.to be_valid }
  end

  context '名前が空' do
    let(:name) { '' }

    it { is_expected.to be_invalid }
  end

  context '名前が重複' do
    before { create(:tag, name: 'dup') }

    let(:name) { 'DUP' }

    it { is_expected.to be_invalid }
  end

  context '名前が長い' do
    let(:name) { 'a' * 81 }

    it { is_expected.to be_invalid }
  end
end
