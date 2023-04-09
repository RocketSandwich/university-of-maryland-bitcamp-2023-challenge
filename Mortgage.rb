require_relative "Read_In.rb"

class Mortgage
    attr_accessor :loan_id, :upb, :note_rate, :borrower_fico, :coborrower_fico, 
    :combined_fico, :state, :dti, :ltv, :maturity_date, :loan_term, :property_type

    def initialize(loan_id, upb, note_rate, borrower_fico, coborrower_fico, 
        combined_fico, state, dti, ltv, maturity_date, loan_term, property_type)

        @loan_id = loan_id
        @upb = upb
        @note_rate = note_rate
        @borrower_fico = borrower_fico
        @coborrower_fico = coborrower_fico
        @combined_fico = combined_fico
        @state = state
        @dti = dti
        @ltv = ltv
        @maturity_date = maturity_date 
        @loan_term = loan_term
        @property_type = property_type
    end
end