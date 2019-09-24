class RankingController < ApplicationController
    before_action :getEntries
    before_action :basic_auth_admin
    caches_action :index, cache_path: -> (c) do build_path(c, @evaluations)end
    caches_action :show1, cache_path: -> (c) do build_path(c, @evaluations)end
    caches_action :show2, cache_path: -> (c) do build_path(c, @evaluations)end
    caches_action :show3, cache_path: -> (c) do build_path(c, @evaluations)end
    
    def index
        @entries.each do |entry|
            if entry.evaluations.size == 0||entry.is_evaluated == false
                entry.evaluation = 0
                next
            end
            sum = entry.evaluations.inject(0) do |i,j|
                i += j.evaluate1
                i += j.evaluate2
                i += j.evaluate3
            end
            entry.evaluation = sum/3.0/entry.evaluations.size
        end
    end

    def show1
        
        @entries.each do |entry|
            if entry.evaluations.size == 0 ||entry.is_evaluated == false
                entry.evaluation = 0
                next
            end
            sum = entry.evaluations.inject(0) do |i,j|
                i += j.evaluate1
            end
            entry.evaluation = sum.to_f/entry.evaluations.size
        end

        render :show
    end

    def show2
        
        @entries.each do |entry|
            if entry.evaluations.size == 0||entry.is_evaluated == false
                entry.evaluation = 0
                next
            end
            sum = entry.evaluations.inject(0) do |i,j|
                i += j.evaluate2
            end
            entry.evaluation = sum.to_f/entry.evaluations.size
        end
        render :show
    end

    def show3
        
        @entries.each do |entry|
            if entry.evaluations.size == 0||entry.is_evaluated == false
                entry.evaluation = 0
                next
            end
            sum = entry.evaluations.inject(0) do |i,j|
                i += j.evaluate3
            end
            entry.evaluation = sum.to_f/entry.evaluations.size
        end
        render :show
    end
    
    def getEntries
        
        @entries = Entry.all
        @evaluations = Evaluation.all
    end
end
