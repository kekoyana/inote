# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Note, type: :model do
  subject { build(:note, tag: tag, body: body) }

  context '正常入力のとき' do
    let(:tag) { create(:tag) }
    let(:body) { 'せいじょう' }

    it { is_expected.to be_valid }
  end

  context 'tagが空' do
    let(:tag) { nil }
    let(:body) { 'せいじょう' }

    it { is_expected.to be_invalid }
  end

  context 'bodyが空' do
    let(:tag) { create(:tag) }
    let(:body) { nil }

    it { is_expected.to be_invalid }
  end

  context 'bodyが長過ぎる' do
    let(:tag) { create(:tag) }
    let(:body) { 'a' * 10_001 }

    it { is_expected.to be_invalid }
  end

  describe '.create_by' do
    subject(:create_by) { described_class.create_by(**params) }

    context 'tagもbodyもあるとき' do
      let(:params) { { tag: 'tag', body: 'body' } }

      it 'trueが戻ること' do
        expect(create_by).to be_truthy
      end

      it 'tags、notesレコードが生成されること' do
        expect { create_by }.to change(Note, :count).by(1).and change(Tag, :count).by(1)
      end
    end

    context 'tagがないとき' do
      let(:params) { { tag: nil, body: 'body' } }

      it 'falseが戻ること' do
        expect(create_by).to be_falsey
      end

      it 'tags、notesレコードが生成されないこと' do
        expect { create_by }.to change(Note, :count).by(0).and change(Tag, :count).by(0)
      end
    end

    context 'bodyがないとき' do
      let(:params) { { tag: 'tag', body: nil } }

      it 'falseが戻ること' do
        expect(create_by).to be_falsey
      end

      it 'tags、notesレコードが生成されないこと' do
        expect { create_by }.to change(Note, :count).by(0).and change(Tag, :count).by(0)
      end
    end
  end
end
