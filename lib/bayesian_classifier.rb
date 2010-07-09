require 'bishop'

class BayesianClassifier
  def initialize
    @guesser = Bishop::Bayes.new { |probs,ignore| Bishop::robinson( probs, ignore ) }
    @guesser.load
  end
  
  def train(tag, body)
    @guesser.train tag, body
    @guesser.save
  end
  
  def guess(content)
    @guesser.guess content
  end
  
end