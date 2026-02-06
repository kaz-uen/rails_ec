# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    # 環境変数が設定されていればそれを使い、なければデフォルト値（admin/pw）を使う設定
    http_basic_authenticate_with(
      name: ENV.fetch('ADMIN_BASIC_AUTH_NAME', 'admin'),
      password: ENV.fetch('ADMIN_BASIC_AUTH_PASSWORD', 'pw')
    )
  end
end
