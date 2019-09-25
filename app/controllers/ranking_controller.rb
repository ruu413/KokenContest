class RankingController < ApplicationController
    #before_action :getEntries
    before_action :basic_auth_admin
    caches_action :index, cache_path: -> (c) do build_path(c, Evaluation.order(:updated_at).last)end
    caches_action :show1, cache_path: -> (c) do build_path(c, Evaluation.order(:updated_at).last)end
    caches_action :show2, cache_path: -> (c) do build_path(c, Evaluation.order(:updated_at).last)end
    caches_action :show3, cache_path: -> (c) do build_path(c, Evaluation.order(:updated_at).last)end
    caches_action :show_soft, cache_path: -> (c) do build_path(c, Evaluation.order(:updated_at).last)end
    caches_action :show_hard, cache_path: -> (c) do build_path(c, Evaluation.order(:updated_at).last)end
    caches_action :show_soft_1, cache_path: -> (c) do build_path(c, Evaluation.order(:updated_at).last)end
    caches_action :show_soft_2, cache_path: -> (c) do build_path(c, Evaluation.order(:updated_at).last)end
    caches_action :show_soft_3, cache_path: -> (c) do build_path(c, Evaluation.order(:updated_at).last)end
    caches_action :show_hard_1, cache_path: -> (c) do build_path(c, Evaluation.order(:updated_at).last)end
    caches_action :show_hard_2, cache_path: -> (c) do build_path(c, Evaluation.order(:updated_at).last)end
    caches_action :show_hard_3, cache_path: -> (c) do build_path(c, Evaluation.order(:updated_at).last)end
    

    def getRank3 entries
        num = 0
        rank=0
        pre_ev=1000
        entries.each do |entry|
            ev = entry.evaluation
            if ev == pre_ev
                
            else
                rank += 1
                if rank > 3
                    break
                end
                pre_ev = ev
            end
            num += 1
        end
        return entries[0,num]

    end

    
    def index
        getEntries
        get_evaluation_mean_all
    end
    def get_evaluation_mean_all
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
        @entries = @entries.sort_by do |e| -e.evaluation end
        @entries = getRank3 @entries
    end
    
    def show1
        getEntries
        get_evaluation_mean_1
        render :show
    end
    def get_evaluation_mean_1
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
        
        @entries = @entries.sort_by do |e| -e.evaluation end
        @entries = getRank3 @entries
    end

    def show2
        getEntries
        get_evaluation_mean_2
        render :show
    end
    def get_evaluation_mean_2
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
        @entries = @entries.sort_by do |e| -e.evaluation end
        @entries = getRank3 @entries
    end

    def show3
        getEntries
        get_evaluation_mean_3
        render "show"
    end
    def get_evaluation_mean_3
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
        @entries = @entries.sort_by do |e| -e.evaluation end
        @entries = getRank3 @entries
    end

    
    def show_soft
        getSoftEntries
        get_evaluation_mean_all
        render "show"
    end
    def show_soft_1
        getSoftEntries
        get_evaluation_mean_1
        render "show"
    end
    def show_soft_2
        getSoftEntries
        get_evaluation_mean_2
        render "show"
    end
    def show_soft_3
        getSoftEntries
        get_evaluation_mean_3
        render "show"
    end

    def show_hard
        getHardEntries
        get_evaluation_mean_all
        render "show"
    end
    def show_hard_1
        getHardEntries
        get_evaluation_mean_1
        render "show"
    end
    def show_hard_2
        getHardEntries
        get_evaluation_mean_2
        render "show"
    end
    def show_hard_3
        getHardEntries
        get_evaluation_mean_3
        render "show"
    end

    def getSoftEntries
        @entries = Entry.where(type:1, is_evaluated: true)
    end
    def getHardEntries
        @entries = Entry.where(type: 0, is_evaluated: true)
    end
    def getEntries
        
        @entries = Entry.where(is_evaluated: true)
        #@evaluations = Evaluation.all
    end
    
  private
    def build_path(controller, model)
        base_path = "cache"
        cache_path = ActionController::Caching::Actions::ActionCachePath.new(controller).path
        cache_path = "#{base_path}:#{model.updated_at.try(:strftime, "%Y%m%d-%H%M%S")}" if model.present?
        cache_path
    end
end
