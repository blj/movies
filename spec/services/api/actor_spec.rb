# frozen_string_literal: true

require 'rails_helper'

describe 'Actor' do
  let(:actor_ids) {
    VCR.use_cassette('actors') do
      API::Actor.ids
    end
  }
  let(:a_actor) {
    VCR.use_cassette 'actors[0]' do
      API::Actor.get(actor_ids[0])
    end
  }
  it 'loads id of all actors in an array' do
    expect(actor_ids).kind_of? Array
    expect(actor_ids[0]).kind_of? Integer
  end
  it 'loads an individual actor for an id' do
    expect(a_actor).to include(:id, :name, :feature_ids)
  end
  context 'when not available' do
    let(:unavailable_actor) {
      VCR.use_cassette 'actors[-2]' do
        API::Actor.get(-2)
      end
    }
    it 'raises RecordNotFound' do
      expect {
        unavailable_actor
      }.to raise_error(API::ResourceNotFound)
    end
  end
end
