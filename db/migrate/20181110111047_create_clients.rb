class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :nom
      t.string :prenom
      t.string :numrue
      t.string :nomrue
      t.string :codepostal
      t.string :ville
      t.string :tel
      t.string :email

      t.timestamps
    end
  end
end
