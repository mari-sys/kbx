Rails.application.routes.draw do
  get "results/show"
  # rootをトップページに設定
  root "home#index"
  # リソースに対してquestionsコントローラーのnewとcreateアクションを設定
  resources :questions, only: [ :new, :create ]
  # 質問ステップ用のルーティングを設定
  get "questions/step/:step", to: "questions#step", as: "question_step"
  # 質問の回答を保存するためのルーティングを設定
  post "questions/answer", to: "questions#answer", as: "question_answer"
  # 質問結果を表示するためのルーティングを設定
  get "results/:id", to: "results#show", as: "result"

  get "questions/reset", to: "questions#reset", as: "reset_questions"

  resources :results, only: [ :index ]


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
