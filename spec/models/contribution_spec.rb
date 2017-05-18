require 'rails_helper'

describe Contribution do
  let(:contribution) { FactoryGirl.build :contribution }
  subject { contribution }

  it { should respond_to(:balance_lcy) }
  it { should respond_to(:balance_fcy) }
  it { should respond_to(:user) }

end
