<template>
  <div class="commentItem-box">
    <div class="avatar">
      <img :src="listItem.c_uavatar" alt />
    </div>
    <div class="content">
      <div class="header-wrap">
        <div class="userid">{{listItem.c_uname}}</div>
        <div class="subtime">{{listItem.create_time}}</div>
      </div>
      <p>{{listItem.c_content}}</p>
      <el-button
        v-if="listItem.c_uid==u_id"
        type="text"
        @click="remove(listItem.c_id)"
        class="delete-button"
      >删除</el-button>
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
  computed: {
    u_id() {
      return (
        (JSON.parse(localStorage.getItem("logged_user"))
          ? JSON.parse(localStorage.getItem("logged_user"))
          : {}
        ).u_id || -1
      );
    }
  },
  watch: {},
  created() {},
  methods: {
    async remove(c_id) {
      let res = await this.$http.delete(`/comments/${c_id}`);
      if (res.data.status == 200) {
        this.$message({
          type: "success",
          message: res.data.msg
        });
        this.$store.commit("UpdateCommentList", res.data.list);
        this.$emit("refreshList", 1);
      } else {
        this.$message({
          type: "error",
          message: res.data.msg
        });
      }
    }
  },
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
      height: 50px;
      margin: 10px 0;
    }

    .delete-button {
      position: absolute;
      // background: red;
      padding: 2px;
      right: 10px;
      top: 60px;
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
