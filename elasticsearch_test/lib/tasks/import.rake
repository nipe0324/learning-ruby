require 'csv'

namespace :db do
  desc "検索用データのCSVファイルをDBに読むこむ"
  task import: :environment do
    folder = ENV['DATA_FOLDER']
    raise "ENV['DATA_FOLDER'] must be required" if folder.blank?

    FILE_NAMES = %w(
      areas.csv
      categories.csv
      prefs.csv
      rating_votes.csv
      ratings.csv
      restaurants.csv
      stations.csv
    )


    FILE_NAMES.each do |file_name|
      line_count = 0
      model_klass = file_name.split('.').first.classify.constantize

      puts "[INFO] Load: #{file_name}"
      CSV.foreach("#{folder}/#{file_name}", { headers: true }) do |row|
        # モデルを作成/更新する
        record = model_klass.find_by(id: row["id"]) || model_klass.new
        record.assign_attributes(row.to_hash)
        record.save

        line_count += 1
        print "-" if line_count % 10_000 == 0
      end
      puts ""

      puts "[INFO] Finish import #{model_klass.name}: #{model_klass.count} records"
    end
  end
end
