class CategoriesController < ApplicationController
    
    before_action :require_admin, except: [:index, :show]
    before_action :require_user, except: [:index, :show]
    
    def index
        @categories = Category.paginate(page: params[:page], per_page: 2)
    end
    
    def show
    end
    
    def new
        @category = Category.new
    end
    
    def create
        @category = Category.new(category_params)
        if @category.save
            flash[:success] = "Category was created successfully"
            redirect_to categories_path
        else
            render 'new'
        end
    end
    
    def category_params
        params.require(:category).permit(:name)
    end
    
    def require_admin
        if logged_in? and !current_user.admin?
            flash[:danger] = "Only admin users can perform that action"
            redirect_to root_path
        end
    end
    
end