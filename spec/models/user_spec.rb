require 'spec_helper'

describe User do

  let(:user) { User.new(name: 'Some User',
                        email: 'user@example.com',
                        password: 'foobar',
                        password_confirmation: 'foobar') }
  let(:invalid_emails) { %w[user@exmple,comma
                            user_at_exple.net
                            example.user@too.many@user_12.com
                            no@pluses+allowed.com] }
  let(:valid_emails) { %w[user@exmple.COm
                          S-OME_usr@sum.plc.org
                          somE.USER@smth.gg
                          pluses+allowed@here.uk] }
  let(:uppercase_email) { 'THiS_IS_upperCASE@somePLACE.CoM' }


  subject { user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe "name" do
    describe "when not present" do
      before { user.name = ' ' }
      it { should_not be_valid }
    end

    describe "when too long" do
      before { user.name = 'x' * 51 }
      it { should_not be_valid }
    end
  end

  describe "email" do
    describe "when not present" do
      before { user.email = ' ' }
      it { should_not be_valid }
    end

    describe "when invalid" do
      it "is invalid" do
        invalid_emails.each do |bad_email|
          user.email = bad_email
          expect(user).not_to be_valid
        end
      end
    end

    describe "when valid" do
      it "is valid" do
        valid_emails.each do |good_email|
          user.email = good_email
          expect(user).to be_valid
        end
      end
    end

    describe "when already taken" do
      before do
        user_dupe = user.dup
        user_dupe.email = user.email.upcase
        user_dupe.save
      end

      it { should_not be_valid }
    end

    describe "when uppercase" do
      it "properly downcases" do
        user.email = uppercase_email
        user.save
        expect(user.reload.email).to eq uppercase_email.downcase
      end
    end
  end

  describe "password" do
    describe "when not present" do
      before { user.password = user.password_confirmation = "" }
      it { should be_invalid }
    end

    describe "when doesn't match confirmation" do
      before { user.password_confirmation = "Doesn't match password" }
      it { should be_invalid }
    end

    describe "when it is too short" do
      before { user.password = user.password_confirmation = "x" * 5 }
      it { should be_invalid }
    end
  end

  describe "authenticate" do
    before { user.save }
    let(:found_user) { User.find_by(email: user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(user.password) }
    end

    describe "with invalid password" do
      let(:user_with_invalid_password) { found_user.authenticate("Nope") }

      it { should_not eq user_with_invalid_password }
      specify { expect(user_with_invalid_password).to be_false }
    end
  end
end
