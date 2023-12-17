class Band < ApplicationRecord
    validates :custom_path, uniqueness: true, allow_nil: true
end
