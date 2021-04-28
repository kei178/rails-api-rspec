require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task) { build(:task) }

  describe 'Validations' do
    it 'is valid' do
      expect(task).to be_valid
    end

    it 'is invalid without a user' do
      task.user = nil
      expect(task).to_not be_valid 
    end
  end
end
