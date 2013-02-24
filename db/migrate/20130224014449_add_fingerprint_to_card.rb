class AddFingerprintToCard < ActiveRecord::Migration
  def change
    add_column :cards, :fingerprint, :string
  end
end
