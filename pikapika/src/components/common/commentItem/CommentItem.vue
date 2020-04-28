<template>
  <div class="commentItem-box">
    <div class="avatar">
      <img :src="listItem.avatarSrc" alt />
    </div>
    <div class="content">
      <div class="header-wrap">
        <div class="userid">{{listItem.userName}}</div>
        <div class="subtime">{{listItem.subtime}}</div>
      </div>
      <p>刚注册账号，第一个评论留念</p>
    </div>
  </div>
</template>

<script>
export default {
  name: "CommentItem",
  props: {
    listItem: {}
  },
  data() {
    return {};
  },
  computed: {},
  watch: {},
  methods: {},
  components: {}
};
</script>

<style lang='less' scoped>
.commentItem-box {
  position: relative;
  margin-top: 20px;
  border-bottom: 1px solid #e5e9ef;
  .avatar {
    float: left;

    // margin-bottom: 6px;
    margin: 10px;
    display: inline-block;
    width: 48px;
    height: 48px;
    border: 1px solid rgba(0, 0, 0, 0.1);
    border-radius: 50%;
    img {
      width: 100%;
      height: 100%;
      border-radius: 50%;
    }
  }

  .content {
    float: right;
    margin-top: 10px;
    width: 93%;
    display: inline-block;
    min-height: 48px;
    font-size: 14px;

    .header-wrap {
      position: relative;
      width: 100%;
      .userid {
        float: left;
        color: #00a1d6;
      }

      .subtime {
        float: right;
        font-weight: 400;
      }
    }

    .header-wrap::after {
      content: "";
      display: block;
      clear: both;
      visibility: hidden;
    }
    p {
      width: 86%;
      margin: 10px 0;
    }
  }
}

.commentItem-box::after {
  content: "";
  display: block;
  clear: both;
  visibility: hidden;
}
</style>
