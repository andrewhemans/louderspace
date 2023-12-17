class AddDetailsToBands < ActiveRecord::Migration[7.0]
  def change
    add_column :bands, :city, :string
    add_column :bands, :state, :string
    add_column :bands, :custom_path, :string
  end
end
