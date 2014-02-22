class AddOriginalFilenameToCard < ActiveRecord::Migration
  def change
    add_column :cards, :original_filename, :string
  end
end
