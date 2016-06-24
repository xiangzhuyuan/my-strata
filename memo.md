--- !ruby/object:OAuth2::Response
response: &1 !ruby/object:Faraday::Response
  on_complete_callbacks: []
  env: !ruby/struct:Faraday::Env
    method: :post
    body: '{"access_token":"d6d3c5bab1694c4c8412294d529d523ab43a7059","token_type":"Bearer","athlete":{"id":558333,"username":"mathewxiang","resource_state":3,"firstname":"matt","lastname":"xiang","city":"Tokyo,
      Japan","state":"Tokyo","country":"Japan","sex":"M","premium":true,"created_at":"2012-05-27T06:22:17Z","updated_at":"2016-06-19T00:22:41Z","badge_type_id":1,"profile_medium":"https://dgalywyr863hv.cloudfront.net/pictures/athletes/558333/3176446/3/medium.jpg","profile":"https://dgalywyr863hv.cloudfront.net/pictures/athletes/558333/3176446/3/large.jpg","friend":null,"follower":null,"follower_count":11,"friend_count":55,"mutual_friend_count":0,"athlete_type":0,"date_preference":"%m/%d/%Y","measurement_preference":"meters","email":"xiangzhuyuan@gmail.com","ftp":null,"weight":75.0,"clubs":[{"id":134155,"resource_state":2,"name":"Paris-Brest-Paris
      Randonneur 2015","profile_medium":"https://dgalywyr863hv.cloudfront.net/pictures/clubs/134155/2669527/2/medium.jpg","profile":"https://dgalywyr863hv.cloudfront.net/pictures/clubs/134155/2669527/2/large.jpg","cover_photo":null,"cover_photo_small":null,"sport_type":"cycling","member_count":759,"featured":false,"url":"parisbrest"}],"bikes":[{"id":"b2338068","primary":true,"name":"giant
      1","resource_state":2,"distance":2231038.0}],"shoes":[{"id":"g1265409","primary":true,"name":"Nike
      Flyknit Max","resource_state":2,"distance":211435.0}]}}'
    url: !ruby/object:URI::HTTPS
      scheme: https
      user:
      password:
      host: www.strava.com
      port: 443
      path: "/oauth/token"
      query:
      opaque:
      registry:
      fragment:
      parser:
    request: !ruby/struct:Faraday::RequestOptions
      params_encoder:
      proxy:
      bind:
      timeout:
      open_timeout:
      boundary:
      oauth:
    request_headers: !ruby/hash:Faraday::Utils::Headers
      User-Agent: Faraday v0.9.2
      Content-Type: application/x-www-form-urlencoded
    ssl: !ruby/struct:Faraday::SSLOptions
      verify: true
      ca_file:
      ca_path:
      verify_mode:
      cert_store:
      client_cert:
      client_key:
      certificate:
      private_key:
      verify_depth:
      version:
      symbolized_key_set: !ruby/object:Set
        hash: {}
    parallel_manager:
    params:
    response: *1
    response_headers: !ruby/hash:Faraday::Utils::Headers
      cache-control: max-age=0, private, must-revalidate
      content-type: application/json; charset=UTF-8
      date: Thu, 23 Jun 2016 11:31:00 GMT
      etag: W/"729535ee700cd7043f2317ce3a59a482"
      set-cookie: _strava3_session=BAh7B0kiD3Nlc3Npb25faWQGOgZFVEkiJWQ5OWJlYTlmOTA2ZTZhZjQ1OThkMDJhZmE2NjBjMzAyBjsAVEkiEGNsZWFyX2NsaWNrBjsARlQ%3D--39421d263b11ac7a18b4b49e8f0f7bf101f3b746;
        domain=strava.com; path=/; HttpOnly
      status: 200 OK
      x-frame-options: DENY
      x-request-id: f7df1b8b5eee312b85d3934923a47ab3
      x-ua-compatible: IE=Edge,chrome=1
      content-length: '673'
      connection: Close
    status: 200
options:
  :parse: :query



####access_token        a


```

  --- !ruby/object:OAuth2::AccessToken
  client: &1 !ruby/object:OAuth2::Client
    id: '12159'
    secret: b48b5dbd9351f67b063708fe24989f0032cbc453
    site: https://www.strava.com
    options:
      :authorize_url: https://www.strava.com/oauth/authorize
      :token_url: oauth/token
      :token_method: :post
      :connection_opts: {}
      :connection_build:
      :max_redirects: 5
      :raise_errors: true
    auth_code: !ruby/object:OAuth2::Strategy::AuthCode
      client: *1
    connection: !ruby/object:Faraday::Connection
      parallel_manager:
      headers: !ruby/hash:Faraday::Utils::Headers
        User-Agent: Faraday v0.9.2
      params: !ruby/hash:Faraday::Utils::ParamsHash {}
      options: !ruby/struct:Faraday::RequestOptions
        params_encoder:
        proxy:
        bind:
        timeout:
        open_timeout:
        boundary:
        oauth:
      ssl: !ruby/struct:Faraday::SSLOptions
        verify: true
        ca_file:
        ca_path:
        verify_mode:
        cert_store:
        client_cert:
        client_key:
        certificate:
        private_key:
        verify_depth:
        version:
        symbolized_key_set: !ruby/object:Set
          hash: {}
      default_parallel_manager:
      builder: !ruby/object:Faraday::RackBuilder
        handlers:
        - !ruby/object:Faraday::RackBuilder::Handler
          name: Faraday::Request::UrlEncoded
          args: []
          block:
        - !ruby/object:Faraday::RackBuilder::Handler
          name: Faraday::Adapter::NetHttp
          args: []
          block:
        app: !ruby/object:Faraday::Request::UrlEncoded
          app: !ruby/object:Faraday::Adapter::NetHttp
            app: !ruby/object:Proc {}
      url_prefix: !ruby/object:URI::HTTPS
        scheme: https
        user:
        password:
        host: www.strava.com
        port: 443
        path: "/"
        query:
        opaque:
        registry:
        fragment:
        parser:
      proxy:
  token: d6d3c5bab1694c4c8412294d529d523ab43a7059
  refresh_token:
  expires_in:
  expires_at:
  options:
    :mode: :header
    :header_format: Bearer %s
    :param_name: access_token
  params:
    token_type: Bearer
    athlete:
      id: 558333
      username: mathewxiang
      resource_state: 3
      firstname: matt
      lastname: xiang
      city: Tokyo, Japan
      state: Tokyo
      country: Japan
      sex: M
      premium: true
      created_at: '2012-05-27T06:22:17Z'
      updated_at: '2016-06-19T00:22:41Z'
      badge_type_id: 1
      profile_medium: https://dgalywyr863hv.cloudfront.net/pictures/athletes/558333/3176446/3/medium.jpg
      profile: https://dgalywyr863hv.cloudfront.net/pictures/athletes/558333/3176446/3/large.jpg
      friend:
      follower:
      follower_count: 11
      friend_count: 55
      mutual_friend_count: 0
      athlete_type: 0
      date_preference: "%m/%d/%Y"
      measurement_preference: meters
      email: xiangzhuyuan@gmail.com
      ftp:
      weight: 75.0
      clubs:
      - id: 134155
        resource_state: 2
        name: Paris-Brest-Paris Randonneur 2015
        profile_medium: https://dgalywyr863hv.cloudfront.net/pictures/clubs/134155/2669527/2/medium.jpg
        profile: https://dgalywyr863hv.cloudfront.net/pictures/clubs/134155/2669527/2/large.jpg
        cover_photo:
        cover_photo_small:
        sport_type: cycling
        member_count: 759
        featured: false
        url: parisbrest
      bikes:
      - id: b2338068
        primary: true
        name: giant 1
        resource_state: 2
        distance: 2231038.0
      shoes:
      - id: g1265409
        primary: true
        name: Nike Flyknit Max
        resource_state: 2
        distance: 211435.0

```