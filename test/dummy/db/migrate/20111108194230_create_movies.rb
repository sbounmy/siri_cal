class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string      :name
      t.references  :user
      t.datetime    :scheduled_at

      t.timestamps
    end
  end
end
