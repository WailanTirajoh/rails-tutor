require 'rails_helper'

describe AuthenticationTokenService do
  describe '.encode' do
    it 'returns an authentication token' do
      user_id = 1
      token = described_class.encode(user_id)
      decoded_token = JWT.decode(
        token,
        described_class::HMAC_SECRET,
        true,
        { algorithm: described_class::ALGORITHM_TYPE }
      )

      expect(decoded_token).to eq(
        [
          { 'user_id' => user_id },
          { 'alg' => 'HS256' }
        ]
      )
    end
  end

  describe '.decode' do
    it 'returns an object representing the decoded token' do
      token = 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.DiPWrOKsx3sPeVClrm_j07XNdSYHgBa3Qctosdxax3w'
      decoded_token = described_class.decode(token)

      expect(decoded_token).to eq(1)
    end
  end
end
