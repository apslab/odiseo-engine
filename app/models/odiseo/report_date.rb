module Odiseo
  class ReportDate
    include ActiveModel::Validations

    attr_accessor :exercise_id, :exercise, :since_date, :until_date

    validates_presence_of :exercise_id, :since_date, :until_date
    validate :date_between_exercise_date?

    def initialize(options = {})
      @exercise_id = options.fetch(:exercise_id, nil)
      @exercise = Exercise.find(exercise_id) rescue nil      
      @since_date = options.fetch(:since_date, '').to_date
      @until_date = options.fetch(:until_date, '').to_date
    end

    def date_between_exercise_date?
      unless exercise.present? && since_date.between?(*exercise.period) && until_date.between?(*exercise.period)
        errors.add(:base, 'La fecha debe estar incluida en el periodo del ejercicio elegido!') 
      end
    end

    def details
      return [] unless valid?
=begin
      @exercise.entries.scoped_by_date_on(@since_date..@until_date)
        .joins(:details)
        .where(:details => {context.class.model_name.foreign_key.to_sym => @context.id})
=end
      Detail.includes(:entry, :account)
        .where(:account_id => exercise.company.accounts.leaves.map(&:id))
        .where(:entries => {:date_on => since_date..until_date, :exercise_id => exercise.id})
        .order('entries.date_on')
    end

    def to_key
      nil
    end
   
  end
end