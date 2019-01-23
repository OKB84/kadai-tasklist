class Task < ApplicationRecord
  validates :content, length: { in: 1..255 }
end
