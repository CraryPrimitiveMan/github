define [
  'app'
  'filters/timeAgoFilter'
  'filters/markdownFilter'
], (app) ->
  app.registerDirective 'eventList', [
    ->
      restrict: 'AE'
      scope:
        items: '='
      replace: true
      template: '<div class="event-list">
          <div class="item" ng-repeat="event in items">
            <p>
              <span class="mega-octicon {{ map[event.type] }}"></span>
              <span>{{ event.created_at | timeAgo }}</span>
            </p>
            <div ng-switch="event.type">
              <div ng-switch-when="WatchEvent">
                <div class="item-avatar">
                  <img ng-src="{{ event.actor.avatar_url }}">
                  <p>
                    <a href="{{ event.actor.url }}">{{ event.actor.login }}</a>
                    {{ event.payload.action }}
                    <a href="{{ event.org.url }}">{{ event.repo.name }}</a>
                  </p>
                </div>
              </div>
              <div ng-switch-when="ForkEvent">
                <div class="item-avatar">
                  <img ng-src="{{ event.actor.avatar_url }}">
                  <p>
                    <a href="{{ event.actor.url }}">{{ event.actor.login }}</a>
                    forked
                    <a href="{{ event.org.url }}">{{ event.repo.name }}</a>
                    to
                    <a href="{{ event.payload.forkee.home_url }}">{{ event.payload.forkee.full_name }}</a>
                  </p>
                </div>
                <p>{{ event.payload.forkee.description }}</p>
              </div>
              <div ng-switch-when="MemberEvent">
                <div class="item-avatar">
                  <img ng-src="{{ event.actor.avatar_url }}">
                  <p>
                    <a href="{{ event.actor.url }}">{{ event.actor.login }}</a>
                    {{ event.payload.action }}
                    <a href="{{ event.payload.member.url }}">{{ event.payload.member.login }}</a>
                    to
                    <a href="{{ event.org.url }}">{{ event.repo.name }}</a>
                  </p>
                </div>
              </div>
              <div ng-switch-when="PushEvent">
                <div class="item-avatar">
                  <img ng-src="{{ event.actor.avatar_url }}">
                  <p>
                    <a href="{{ event.actor.url }}">{{ event.actor.login }}</a>
                    pushed to
                    <a href="{{ event.payload.ref }}">{{ event.payload.ref.replace("refs/heads/", "") }}</a>
                    at
                    <a href="{{ event.org.url }}">{{ event.repo.name }}</a>
                  </p>
                </div>
                <p ng-repeat="commit in event.payload.commits">
                  <a>{{ commit.sha.substr(0, 7) }}</a>
                  {{ commit.message }}
                </p>
              </div>
              <div ng-switch-when="IssueCommentEvent">
                <div class="item-avatar">
                  <img ng-src="{{ event.actor.avatar_url }}">
                  <p>
                    <a href="{{ event.actor.url }}">{{ event.actor.login }}</a>
                    commented on issue
                    <a href="{{ event.org.url }}">{{ event.repo.name + "#" + event.payload.issue.number }}</a>
                  </p>
                </div>
                <p ng-bind-html="event.payload.comment.body | markdown"></p>
              </div>
              <div ng-switch-when="PullRequestEvent">
                <div class="item-avatar">
                  <img ng-src="{{ event.actor.avatar_url }}">
                  <p>
                    <a href="{{ event.actor.url }}">{{ event.actor.login }}</a>
                    commented on issue
                    <a href="{{ event.org.url }}">{{ event.repo.name + "#" + event.payload.number }}</a>
                  </p>
                </div>
                <p ng-bind-html="event.payload.pull_request.title | markdown"></p>
              </div>
            </div>
          </div>
      </div>'
      link: (scope) ->
        scope.map =
          WatchEvent: 'octicon-star'
          ForkEvent: 'octicon-git-branch'
          MemberEvent: 'octicon-person'
          PushEvent: 'octicon-git-commit'
          PullRequestEvent: 'octicon-git-pull-request'
          IssueCommentEvent: 'octicon-comment-discussion'
        return
  ]
