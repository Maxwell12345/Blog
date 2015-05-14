class CommentsController < ApplicationController

	http_basic_authenticate_with name: "ana", password: "ana",
	only: :destroy

	def show
    	@comment = Comment.find(params[:id])
  	end

  	def new
    	@comment = Comment.new
  	end

  	def edit
  		@comment = Comment.find(params[:id])
  		@article = Article.find(params[:article_id])
	end


	def create
		@article = Article.find(params[:article_id])
		# create automatically link comment to belong to article
		@comment = @article.comments.create(comment_params) #@article.comments hierarchy
		redirect_to article_path(@article)
	end

	def update
		@article = Article.find(params[:article_id])
		@comment = @article.comments.find(params[:id])

		@comment.update_attributes(comment_params)
		redirect_to @article
		
	end

	def destroy
		@article = Article.find(params[:article_id])
		@comment = @article.comments.find(params[:id])
		@comment.destroy

		redirect_to article_path(@article)
	end

	private
		def comment_params
			params.require(:comment).permit(:commenter, :body)
		end

end
