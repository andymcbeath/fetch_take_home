Rails.application.routes.draw do
  post "/receipts/process" => "receipts#process_receipt"
  get "/receipts/:id/points" => "receipts#points"
end
