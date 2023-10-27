CREATE MIGRATION m1j6xhyy7cpzcwtwoilel56ahnf6k4mgpu6j4ule7txae7axwczdoq
    ONTO m1ypswx663vv3apl6rt5xaxv3zcwtfakxz7qcmmtaqh2oj5tcviojq
{
  CREATE SCALAR TYPE default::QueueId EXTENDING std::sequence;
  ALTER TYPE default::CommunityQueue {
      ALTER PROPERTY community_queue_id {
          SET TYPE default::QueueId USING (<default::QueueId>.community_queue_id);
      };
  };
  ALTER TYPE default::FlashQueue {
      ALTER PROPERTY flash_queue_id {
          SET TYPE default::QueueId USING (<default::QueueId>.flash_queue_id);
      };
  };
  ALTER TYPE default::QuestionQueue {
      ALTER PROPERTY question_queue_id {
          SET TYPE default::QueueId USING (<default::QueueId>.question_queue_id);
      };
  };
};
