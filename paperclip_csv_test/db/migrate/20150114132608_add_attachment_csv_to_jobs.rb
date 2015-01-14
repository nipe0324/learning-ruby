class AddAttachmentCsvToJobs < ActiveRecord::Migration
  def self.up
    change_table :jobs do |t|
      t.attachment :csv
    end
  end

  def self.down
    remove_attachment :jobs, :csv
  end
end
