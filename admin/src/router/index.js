import Vue from 'vue'
import Router from 'vue-router'
import Index from '@/components/main/Index'
import Main from '@/components/main/Main'
import Login from '@/components/login/Login'
import BangumiEdit from '@/components/bangumi/BangumiEdit'
import BangumiList from '@/components/bangumi/BangumiList'
import GuomanEdit from '@/components/guoman/GuomanEdit'
import GuomanList from '@/components/guoman/GuomanList'
import TheaterEdit from '@/components/theater/TheaterEdit'
import TheaterList from '@/components/theater/TheaterList'
import FilmTVEdit from '@/components/filmtv/FilmTVEdit'
import FilmTVList from '@/components/filmtv/FilmTVList'
import UserinfoEdit from '@/components/userinfo/UserinfoEdit'
import UserinfoList from '@/components/userinfo/UserinfoList'
import AdminUserEdit from '@/components/adminuser/AdminUserEdit'
import AdminUserList from '@/components/adminuser/AdminUserList'
import CarouselEdit from '@/components/carousel/CarouselEdit'
import CarouselList from '@/components/carousel/CarouselList'
import AdsEdit from '@/components/ads/AdsEdit'
import AdsList from '@/components/ads/AdsList'
import AnnounceEdit from '@/components/announce/AnnounceEdit'
import AnnounceList from '@/components/announce/AnnounceList'
import ReportList from '@/components/report/ReportList'

import Test from '@/components/test'
import Test2 from '@/components/Test2'


Vue.use(Router)

const originalPush = Router.prototype.push;
Router.prototype.push = function push(location) {
  return originalPush.call(this, location).catch(err => err)
};

const router = new Router({
  mode:'history',
  routes: [
    {
      path: '/login',
      component: Login,
      meta: { isPublic: true }
    },
    {
      path: '/',
      component: Main,
      children: [
        { path: '', component: Index },

        { path: '/bangumi/create', component: BangumiEdit },
        { path: '/bangumi/eidt/:film_id', component: BangumiEdit, props: true },
        { path: '/bangumi/list', component: BangumiList },

        { path: '/guoman/create', component: GuomanEdit },
        { path: '/guoman/eidt/:film_id', component: GuomanEdit, props: true },
        { path: '/guoman/list', component: GuomanList },

        { path: '/theater/create', component: TheaterEdit },
        { path: '/theater/eidt/:film_id', component: TheaterEdit, props: true },
        { path: '/theater/list', component: TheaterList },

        { path: '/filmtv/create', component: FilmTVEdit },
        { path: '/filmtv/eidt/:film_id', component: FilmTVEdit, props: true },
        { path: '/filmtv/list', component: FilmTVList },

        { path: '/userinfo/create', component: UserinfoEdit },
        { path: '/userinfo/eidt/:film_id', component: UserinfoEdit, props: true },
        { path: '/userinfo/list', component: UserinfoList },

        { path: '/adminuser/create', component: AdminUserEdit },
        { path: '/adminuser/eidt/:admin_id', component: AdminUserEdit, props: true },
        { path: '/adminuser/list', component: AdminUserList },

        { path: '/carousel/create', component: CarouselEdit },
        { path: '/carousel/eidt/:carousel_id', component: CarouselEdit, props: true },
        { path: '/carousel/list', component: CarouselList },

        { path: '/ads/create', component: AdsEdit },
        { path: '/ads/eidt/:ad_id', component: AdsEdit, props: true },
        { path: '/ads/list', component: AdsList },

        { path: '/announce/create', component: AnnounceEdit },
        { path: '/announce/eidt/:announce_id', component: AnnounceEdit, props: true },
        { path: '/announce/list', component: AnnounceList },

        { path: '/report/list', component: ReportList },
      ]
    },
    {
      path: '/test',
      component: Test
    },
    {
      path: '/test2',
      component: Test2
    },
    {
      path:'*',
      redirect:'/'
    }
  ]
});

router.beforeEach((to, from, next) => {
  if(!to.meta.isPublic && !localStorage.token){
    return next('login');
  }
  next();
})

export default router;
