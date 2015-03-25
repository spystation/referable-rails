class User < ActiveRecord::Base

  belongs_to :referrer, class_name: 'User', foreign_key: 'referrer_id'
  has_many :referrals, class_name: 'User', foreign_key: 'referrer_id'

  validates :email, uniqueness: true
  validates :referral_code, uniqueness: true


  before_create :create_referral_code

  private

    def create_referral_code
      referral_code = SecureRandom.hex(5)
      @collision = User.find_by_referral_code(referral_code)

      while !@collision.nil?
        referral_code = SecureRandom.hex(5)
        @collision = User.find_by_referral_code(referral_code)
      end

      self.referral_code = referral_code
    end

end
