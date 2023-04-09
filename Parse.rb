require_relative "Mortgage.rb"
require "sysvipc"

class Parse
    def initialize(data_file1, data_file2, data_file3, data_file4)
        
        # 3 child processes ; 4 total
        r1, w1 = IO.pipe
        r2, w2 = IO.pipe
        r3, w3 = IO.pipe
        pid1 = fork {
            r1.close
            i = 0
            f = File.open(data_file1)
            line = f.gets # Skip first line
            line = f.gets
            m_lst = []
            class_lst = {:Class1 => [], :Class2 => [], :Class3 => [], :Class4 => [], :Class5 => [], 
                :Class6 => [], :Class7 => [], :Class8 => [], :Class9 => [], :Class10 => []}

            while line
                arr = line.split(/|/)
                line = f.gets           # loan_id,   upb,  note_rate, borrower_fico, coborrower_fico, combined_fico, state,    dti,    ltv,    maturity_date, loan_term, property_type
                # m_lst.push(Mortgage.new(line[0], line[1], line[2],      line[3],       line[4],        line[5],   line[6], line[7], line[8],    line[9],     line[10],   line[11]))
                loan_id = line[0]
                upb = line[1].to_f
                note_rate = line[2].to_f
                borrower_fico = line[3].to_i
                coborrower_fico = line[4]
                combined_fico = line[5].to_i
                state = line[6]
                dti = line[7].to_i
                ltv = line[8].to_i
                maturity_date = line[9]
                loan_term = line[10].to_i
                property_type = line[11]

                # Sort based on **CLASS CONSTRAINTS** (prioritizing lower-level classes)
                if (note_rate >= 5.0 && note_rate <= 7.0) && (combined_fico >= 640 && combined_fico <= 745) && (dti >= 35 && dti <= 50) && (ltv >= 75 && ltv <= 85)
                    class_lst[:Class1].push(Mortgage.new(loan_id, upb, note_rate, borrower_fico, coborrower_fico, combined_fico, state, dti, ltv, maturity_date, loan_term, property_type))
                elsif (note_rate >= 4.0 && note_rate <= 6.0) && (combined_fico >= 600 && combined_fico <= 770) && (dti >= 40 && dti <= 45) && (ltv >= 70 && ltv <= 90)
                    class_lst[:Class2].push(Mortgage.new(loan_id, upb, note_rate, borrower_fico, coborrower_fico, combined_fico, state, dti, ltv, maturity_date, loan_term, property_type))
                elsif (note_rate >= 3.0 && note_rate <= 7.0) && (combined_fico >= 600 && combined_fico <= 700) && (dti >= 45 && dti <= 55) && (ltv >= 60 && ltv <= 95)
                    class_lst[:Class3].push(Mortgage.new(loan_id, upb, note_rate, borrower_fico, coborrower_fico, combined_fico, state, dti, ltv, maturity_date, loan_term, property_type))
                elsif (note_rate >= 3.0 && note_rate <= 7.0) && (combined_fico >= 670 && combined_fico <= 750) && (dti >= 47 && dti <= 52) && (ltv >= 35 && ltv <= 80)
                    class_lst[:Class4].push(Mortgage.new(loan_id, upb, note_rate, borrower_fico, coborrower_fico, combined_fico, state, dti, ltv, maturity_date, loan_term, property_type))
                elsif (note_rate >= 3.0 && note_rate <= 7.0) && (combined_fico >= 675 && combined_fico <= 780) && (dti >= 30 && dti <= 55) && (ltv >= 60 && ltv <= 85)
                    class_lst[:Class5].push(Mortgage.new(loan_id, upb, note_rate, borrower_fico, coborrower_fico, combined_fico, state, dti, ltv, maturity_date, loan_term, property_type))
                elsif (note_rate >= 3.0 && note_rate <= 7.0) && (combined_fico >= 690 && combined_fico <= 790) && (dti >= 15 && dti <= 35) && (ltv >= 70 && ltv <= 85)
                    class_lst[:Class6].push(Mortgage.new(loan_id, upb, note_rate, borrower_fico, coborrower_fico, combined_fico, state, dti, ltv, maturity_date, loan_term, property_type))
                elsif (note_rate >= 2.0 && note_rate <= 5.0) && (combined_fico >= 720 && combined_fico <= 850) && (dti >= 10 && dti <= 45) && (ltv >= 70 && ltv <= 80)
                    class_lst[:Class7].push(Mortgage.new(loan_id, upb, note_rate, borrower_fico, coborrower_fico, combined_fico, state, dti, ltv, maturity_date, loan_term, property_type))
                elsif (note_rate >= 1.5 && note_rate <= 7.0) && (combined_fico >= 550 && combined_fico <= 740) && (dti >= 20 && dti <= 45) && (ltv >= 0 && ltv <= 85)
                    class_lst[:Class8].push(Mortgage.new(loan_id, upb, note_rate, borrower_fico, coborrower_fico, combined_fico, state, dti, ltv, maturity_date, loan_term, property_type))
                elsif (note_rate >= 1.5 && note_rate <= 9.0) && (combined_fico >= 730 && combined_fico <= 770) && (dti >= 35 && dti <= 45) && (ltv >= 90 && ltv <= 95)
                    class_lst[:Class9].push(Mortgage.new(loan_id, upb, note_rate, borrower_fico, coborrower_fico, combined_fico, state, dti, ltv, maturity_date, loan_term, property_type))
                elsif (note_rate >= 1.5 && note_rate <= 6.5) && (combined_fico >= 400 && combined_fico <= 850) && (dti >= 20 && dti <= 60) && (ltv >= 70 && ltv <= 99)
                    class_lst[:Class10].push(Mortgage.new(loan_id, upb, note_rate, borrower_fico, coborrower_fico, combined_fico, state, dti, ltv, maturity_date, loan_term, property_type))
                end

                # Sort from each class based on **POOL CONSTRAINTS**
                pools = [[]]
                class_lst.each do |k, v|
                    for i in 0..(v.length)
                        for j in pools
                            if v[i].maturity_date == j[0].maturity_date
                        end 
                    end
                end

                i = i + 1
                print i.to_s + ", "
            end



            w1.write(m_lst)
            w1.close
        }

        if pid1.nil?
            puts "Child Process 1 Failed to Spawn"
        else 
            pid2 = fork {
                r2.close
                i = 0
                f = File.open(data_file2)
                line = f.gets
                m_lst = []
                
                while line
                    arr = line.split(/|/)
                    line = f.gets
                    m_lst.push(Mortgage.new(line[0], line[1], line[2], line[3], line[4], line[5], line[6], line[7], line[8], line[9], line[10], line[11]))

                    i = i + 1
                    print i.to_s + ", "
                end

                w2.write(m_lst)
                w2.close
            }   

            if pid2.nil?
                puts "Child Process 2 Failed to Spawn"
            else 
                pid3 = fork {
                    r3.close
                    i = 0
                    f = File.open(data_file3)
                    line = f.gets
                    m_lst = []
                    
                    while line
                        arr = line.split(/|/)
                        line = f.gets
                        m_lst.push(Mortgage.new(line[0], line[1], line[2], line[3], line[4], line[5], line[6], line[7], line[8], line[9], line[10], line[11]))

                        i = i + 1
                        print i.to_s + ", "
                    end

                    w3.write(m_lst)
                    w3.close
                }   

                if pid3.nil?
                    puts "Child Process 3 Failed to Spawn"
                else 
                    i = 0
                    f = File.open(data_file4)
                    line = f.gets
                    m_lst = []

                    while line
                        arr = line.split(/|/)
                        line = f.gets
                        m_lst.push(Mortgage.new(line[0], line[1], line[2], line[3], line[4], line[5], line[6], line[7], line[8], line[9], line[10], line[11]))

                        i = i + 1
                        print i.to_s + ", "
                    end

                    # total_lst = m_lst + r1.read + r2.read + r3.read
                end
            end
        end
        Process.waitall
    end
end