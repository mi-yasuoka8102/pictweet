require 'rails_helper'
describe User do
  describe '#create' do

     it "is invalid without a nickname" do
      #nicknameが空だと登録できない
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    it "is invalid without a email" do
      #emailが空だと登録できない
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid without a password" do
      #passwordが空だと登録できない
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "is invalid without a password_confirmation although with a password" do
      #password が入力されていてもdoesn't match Password が空(違う)だと登録できない
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it "is invalid with a nickname that has more than 7 characters" do
      #nicknameが7文字以上であれば登録できない
      user = build(:user, nickname: "abcdefg")
      user.valid?
      expect(user.errors[:nickname]).to include("is too long (maximum is 6 characters)")
    end

    it "is valid with a nickname that has less than 6 characters " do
      # nicknameが6文字以下では登録できる
      user = build(:user, nickname: "abcdef")
      user.valid?
      expect(user).to be_valid
    end

    it "is invalid with a password that has less than 5 characters " do
      #passwordが5文字以下であれば登録できない
      user = build(:user, password: "abcde", password_confirmation: "abcde")
      user.valid?
      expect(user.errors[:password][0]).to include("is too short")
    end

    it "is valid with a password that has less than 6 characters " do
      # passwordが6文字以下では登録できる
      user = build(:user, password: "abcdef", password_confirmation: "abcdef")
      user.valid?
      expect(user).to be_valid
    end

    it "is valid with a nickname, email, password, password_confirmation" do
      # 登録できる
      user = build(:user)
      expect(user).to be_valid
    end

    it "is invalid with a duplicate email address" do
      # 重複したemailが存在する場合登録できないこと
      #はじめにユーザーを登録
      user = create(:user)
      #先に登録したユーザーと同じemailの値を持つユーザーのインスタンスを作成
      another_user = build(:user)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

    # ここから別解
    it "is invalid with a nickname that has more than 7 characters " do
      user = build(:user, nickname: "aaaaaaaa")
      user.valid?
      expect(user.errors[:nickname][0]).to include("is too long")
    end

    it "is invalid with a password that has less than 5 characters " do
      user = build(:user, password: "00000", password_confirmation: "00000")
      user.valid?
      expect(user.errors[:password][0]).to include("is too short")
    end

  end
end
