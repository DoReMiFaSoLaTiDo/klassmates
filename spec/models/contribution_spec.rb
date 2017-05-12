require 'rails_helper'

describe Contribution do
  let(:contribution) { FactoryGirl.build :contribution }
  subject { contribution }

  it { should respond_to(:amount_lcy) }
  it { should respond_to(:amount_fcy) }

end
