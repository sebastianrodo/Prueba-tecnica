class Csv < ApplicationRecord
  self.per_page = 5

  include AASM

  belongs_to :user
  has_many :contacts, dependent: :delete_all
  has_one_attached :file
  validates :file, presence: true

  aasm column: :state do
    state :on_hold, initial: true, display: 'On Hold'
    state :processing, display: 'Processing'
    state :failed, display: 'Failed'
    state :finished, display: 'Finished'

    event :hold_on do
      transitions from: [:processing, :failed, :finished, :on_hold], to: :on_hold
    end

    event :process do
      transitions from: [:on_hold, :failed, :finished, :processing], to: :processing
    end

    event :fail do
      transitions from: [:on_hold, :processing, :finished, :failed], to: :failed
    end

    event :finish do
      transitions from: [:on_hold, :processing, :failed, :finished], to: :finished
    end
  end
end
