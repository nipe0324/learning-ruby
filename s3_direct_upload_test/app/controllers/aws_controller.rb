class AwsController < ApplicationController
  def policies
    render json: generate_policy_hash
  end

  private

    # modelやpolicyオブジェクトで処理をさせる方が良さそう
    def generate_policy_hash
      file_name = params[:file_name]
      content_type = params[:content_type]
      size = params[:size]

      key = "uploads/#{SecureRandom.uuid}/#{file_name}"

      policy_document = {
        expiration: (Time.zone.now + 1.minitute).utc,
        conditions: [
          { bucket: ENV['BUCKET_NAME'] },
          { key: key },
          { 'Content-Type' => content_type },
          { acl: "public-read" },
          { success_action_status: "201" },
          [ "content-length-range",  size, size ]
        ]
      }.to_json
      policy = Base64.encode64(policy_document).gsub("\n", '')

      signature = Base64.encode64(
        OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha1'), ENV['AWS_SECRET_KEY'], policy)
      ).gsub("\n", '')

      return {
        url: "https://#{ENV['BUCKET_NAME']}.s3.amazonaws.com/",
        form: {
          'AWSAccessKeyId' => ENV['AWS_ACCESS_KEY'],
          key: key,
          policy: policy,
          signature: signature,
          acl: 'public-read',
          success_action_status: '201',
          "Content-Type" => content_type
        }
      }
    end
end
