class AwsController < ApplicationController

  def s3_policy
    render json: s3_policy_response
  end

  private

    def s3_presigned_post
      @s3_presigned_post ||= S3_BUCKET.presigned_post(
        key: "uploads/#{SecureRandom.uuid}/${filename}",
        success_action_status: '201',
        acl: 'public-read',
        content_type: 'image/',
        content_length_range: 0..100.megabytes,
        signature_expiration: (Time.zone.now + 5.minutes).utc)
    end

    def s3_policy_response
      logger.debug "form-data:#{s3_presigned_post.fields}"
      logger.debug "url:#{s3_presigned_post.url}"
      logger.debug "host:#{URI.parse(s3_presigned_post.url).host}"

      {
        data: s3_presigned_post.fields,
        url:  s3_presigned_post.url,
        host: URI.parse(s3_presigned_post.url).host
      }
    end
end
