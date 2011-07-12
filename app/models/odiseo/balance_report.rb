require 'ostruct'

module Odiseo
  class BalanceReport
    include ActiveModel::Validations

    attr_accessor :company, :exercise_id, :exercise, :since_date, :until_date

    validates_presence_of :exercise_id, :since_date, :until_date

    validate :until_date_between_exercise_date?

    def initialize(company, options = {})
      @company = company
      @exercise_id = options.fetch(:exercise_id, nil)
      @since_date = options.fetch(:since_date, '').to_date
      @until_date = options.fetch(:until_date, '').to_date
    end

    def exercise
      @exercise ||= Exercise.find(exercise_id)
    end

    def until_date_between_exercise_date?
      unless exercise.present? && since_date.between?(*exercise.period) && until_date.between?(*exercise.period)
        errors.add(:base, 'La fecha debe estar incluida en el periodo del ejercicio elegido!') 
      end
    end

    def accounts
      return Kaminari::PaginatableArray.new([]) unless valid?
      details = Detail.select('distinct details.account_id as name, sum(details.credit) as credit, sum(details.debit) as debit')
        .joins(:entry)
        .where(:entries => {:exercise_id => exercise.id})
        .where(:account_id => exercise.company.accounts.leaves.map(&:id))
        .where(:entries => {:date_on => since_date..until_date})
        .group(:account_id)

      Kaminari::PaginatableArray.new(details.map!(&normalize))
    end

    def to_key
      nil
    end

    private

    def normalize
      @normalize ||= lambda do |account|
        account.name = company.accounts.leaves.detect{|leave| leave.id == account.name.to_i}.try(:name)
        account
      end
    end
   
  end
end