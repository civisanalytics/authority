require 'spec_helper'
require 'support/example_model'
require 'support/user'

describe Authority::Authorizer do

  before :each do
    @example_model = ExampleModel.new
    @authorizer    = @example_model.authorizer
    @user          = User.new
  end

  it "takes a resource instance in its initializer" do
    expect(@authorizer.resource).to eq(@example_model)
  end

  describe "instance methods" do

    Authority.adjectives.each do |adjective|
      method_name = "#{adjective}_by?"

      it "responds to `#{method_name}`" do
        expect(@authorizer).to respond_to(method_name)
      end

      describe "#{method_name}" do

        context "when given an options hash" do

          it "delegates `#{method_name}` to the corresponding class method, passing the options" do
            @authorizer.class.should_receive(method_name).with(@user, :under => 'God')
            @authorizer.send(method_name, @user, :under => 'God')
          end

        end

        context "when not given an options hash" do

          it "delegates `#{method_name}` to the corresponding class method, passing no options" do
            @authorizer.class.should_receive(method_name).with(@user)
            @authorizer.send(method_name, @user)
          end

        end

      end

    end

  end

  describe "class methods" do

    Authority.adjectives.each do |adjective|
      method_name = "#{adjective}_by?"

      it "responds to `#{method_name}`" do
        expect(Authority::Authorizer).to respond_to(method_name)
      end

      describe "#{method_name}" do

        context "when given an options hash" do

          it "delegates `#{method_name}` to the authorizer's `default` method, passing the options" do
            able = method_name.sub('_by?', '').to_sym
            Authority::Authorizer.should_receive(:default).with(able, @user, :with => 'gusto')
            Authority::Authorizer.send(method_name, @user, :with => 'gusto')
          end

        end

        context "when not given an options hash" do

          it "delegates `#{method_name}` to the authorizer's `default` method, passing no options" do
            able = method_name.sub('_by?', '').to_sym
            Authority::Authorizer.should_receive(:default).with(able, @user)
            Authority::Authorizer.send(method_name, @user)
          end

        end

      end

    end

  end

  describe "the default method" do

    describe "if given an options hash" do

      it "returns false" do
        expect(Authority::Authorizer.default(:implodable, @user, {:for => "my_object"})).to be_false
      end
    end

    describe "if not given an options hash" do

      it "returns false" do
        expect(Authority::Authorizer.default(:implodable, @user)).to be_false
      end

    end

  end

  describe "the `authorizes?` method" do

    it "calls a method by the name of the symbol given" do
      Authority::Authorizer.should_receive(:play_bagpipes?).with(@user)
      Authority::Authorizer.authorizes?(:play_bagpipes, @user)
    end

  end

end
