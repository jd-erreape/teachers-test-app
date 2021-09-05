# frozen_string_literal: true

RSpec.shared_examples 'show with resource' do |resource|
  let(:resource_instance) { create(resource) }

  def do_show(resource_id)
    get :show, params: { id: resource_id }
  end

  context 'when the resource requested exist' do
    before { do_show(resource_instance.id) }

    include_examples 'render 200 html template' do
      let(:template) { 'show' }
    end

    it 'assigns the resource' do
      expect(assigns[resource.to_s]).to eq(resource_instance)
    end
  end

  context 'when the resource requested does not exist' do
    before { do_show(-1) }

    it 'redirects to resource index path' do
      expect(response).to redirect_to(send("#{resource.to_s.pluralize}_path"))
    end

    it 'sets proper flash message' do
      expect(response.request.flash[:alert]).to eq(described_class::RESOURCE_DOESNT_EXIST_MESSAGE)
    end
  end
end
