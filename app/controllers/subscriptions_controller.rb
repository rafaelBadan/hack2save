class SubscriptionsController < ApplicationController
    load_and_authorize_resource
    
    before_action :get_subscription, only: [:edit, :update, :show]

    def index
        @subscriptions = subscription_scope
    end

    def new
        @subscription = subscription_scope.build
    end

    def create
        build_subscription
        if @subscription.save
            redirect_to subscription_path(@subscription.id) 
        else
            render(:new, status: :unprocessable_entity)
        end
    end

    def edit
    end

    def update
        if @subscription.update_attributes(subscription_params) 
            redirect_to subscription_path(@subscription.id) 
        else
            render(:edit, status: :unprocessable_entity)
        end
    end

    def show
    end
    
    private

    def get_subscription
        @subscription = Subscription.find(params[:id])
    end

    def build_subscription
        @subscription ||= subscription_scope.build
        @subscription.attributes = subscription_params
    end


    def subscription_params
        return {} unless params[:subscription].present?
        params.require(:subscription).permit(:id, :user_id, :job_id, :status, :cover_letter)
    end

    def subscription_scope
        Job.find(params[:job_id]).subscriptions
    end

end