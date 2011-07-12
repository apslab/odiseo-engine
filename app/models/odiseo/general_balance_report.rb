require 'ostruct'

module Odiseo
  class GeneralBalanceReport
    include ActiveModel::Validations

    attr_accessor :exercise_id, :exercise, :since_date, :until_date
    attr_reader :exercise, :company, :data

    validates_presence_of :exercise_id, :until_date

    validate :until_date_between_exercise_date?

    def initialize(options = {})
      @exercise_id = options.fetch(:exercise_id, nil)
      @until_date = options.fetch(:until_date, '').to_date
    end

    def exercise
      @exercise ||= Exercise.find(exercise_id)
    end

    def company
      @company ||= @exercise.try(:company)
    end

    def until_date_between_exercise_date?
      unless exercise.present? && since_date.between?(*exercise.period) && until_date.between?(*exercise.period)
        errors.add(:base, 'La fecha debe estar incluida en el periodo del ejercicio elegido!') 
      end
    end

    def since_date
      @since_date ||= @exercise.started_on
    end

    def accounts
      Kaminari::PaginatableArray.new(to_ostruct)
    end

    def to_ostruct
      return data if data.empty?

      icons = %w(blue green orange pink red yellow purple)
      Account.map_with_level(company.accounts.roots.map(&:self_and_descendants).flatten) do |account, level|
        name = ("&nbsp;\t&nbsp;" * level) + '<img src="/images/icons/16x16/tag_'+ icons.at(level.modulo(icons.size)) +'.png" width="16" height="16" />' + account.name 
        credit, debit = sumarize_credit_and_debit_for_this_ids(account.self_and_descendants.map(&:id))
        OpenStruct.new(:name => name, :credit => credit, :debit => debit)
      end
    end

    def sumarize_credit_and_debit_for_this_ids(ids)
      selection = data.select{|item|ids.include?(item.id)}
      [selection.sum(&:credit), selection.sum(&:debit)]
    end

    def data
      return [] unless valid?

      @data ||= Detail.select('details.account_id as id, sum(details.credit) as credit, sum(details.debit) as debit')
        .joins(:entry, :account)
        .where(:entries => {:exercise_id => exercise.id})
        .where(:account_id => exercise.company.accounts.leaves.map(&:id))
        .where(:entries => {:date_on => since_date..until_date})
        .group(:account_id)
    end

    def to_key
      nil
    end
   
  end
end