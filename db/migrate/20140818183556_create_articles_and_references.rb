class CreateArticlesAndReferences < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.references :campaign, :index => true
      t.text :url
      t.timestamps
    end

    change_table :links do |t|
      t.references :article, :index => true
    end
    change_table :click_throughs do |t|
      t.references :article, :index => true
    end
    change_table :shares do |t|
      t.references :article, :index => true
    end
  end
end
