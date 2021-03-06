require 'spec_helper'

describe Mutant::Subject, '#each' do
  subject { object.each { |item| yields << item } }

  let(:class_under_test) do
    mutations = [mutation_a, mutation_b]
    Class.new(described_class) do
      define_method(:mutations) { mutations }
    end
  end

  let(:object)     { class_under_test.new(context, node) }
  let(:yields)     { []                                  }
  let(:node)       { mock('Node')                        }
  let(:context)    { mock('Context')                     }
  let(:mutant)     { mock('Mutant')                      }
  let(:mutation_a) { mock('Mutation A')                  }
  let(:mutation_b) { mock('Mutation B')                  }

  it_should_behave_like 'an #each method'

  let(:neutral_mutation) do
    Mutant::Mutation::Neutral.new(object, node)
  end

  it 'yields mutations' do
    expect { subject }.to change { yields.dup }.from([])
      .to([neutral_mutation, mutation_a, mutation_b])
  end
end
