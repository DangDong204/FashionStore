package vn.devpro.javaweb32.configurer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;

import vn.devpro.javaweb32.service.UserDetailsServiceImpl;

@Configuration
@EnableWebSecurity
public class SecureConfigurer extends WebSecurityConfigurerAdapter{
	
	@Override
	protected void configure(final HttpSecurity http) throws Exception{
		
		http.csrf().disable().authorizeRequests()
		
		// 1. Cho phep cac request, paths khong bi rang buoc (khong login van xem duoc)
		.antMatchers("/administrator/**", "/customer/**", "/UploadFiles/**", "/login", "/logout" )
		.permitAll()
		
		// 2. Cac request kieu "/admin/..." phai login xac thuc truoc
		//.antMatchers("/admin/**").authenticated()	// step 1+2
		
		.antMatchers("/admin/**").hasAnyAuthority("ADMIN")
		
		.and()
		
		//Direct den URL duoc request truoc khi login
		.requestCache().requestCache(new HttpSessionRequestCache())

		.and()
		
		// 3. action "/login" la cua minh - neu khong co se vao trang login cua spring
		.formLogin().loginPage("/login").loginProcessingUrl("/login_processing_url")
		//.defaultSuccessUrl("/admin/home", true)	// login thanh cong
		.successHandler(new UrlAuthenticationSuccessHandler())

		.failureUrl("/login?login_error=true")	// login khong thanh cong
		
		.and()
		
		// Cau hinh phan logout
		.logout().logoutUrl("/logout").logoutSuccessUrl("/index").invalidateHttpSession(true)
		.deleteCookies("JSESSIONID")
		// Cau hinh phan rememberMe
		.and().rememberMe().key("uniqueAndSecret").tokenValiditySeconds(86400); //86400s = 24h

	}
	
	@Autowired
	private UserDetailsServiceImpl userDetailsService;

	@Autowired //Cach xac thuc bao mat voi user load tu DB
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userDetailsService).passwordEncoder(
				new BCryptPasswordEncoder(4));
	}

	public static void main(String[] args) {
		System.out.println(new BCryptPasswordEncoder(4).encode("123"));
	}
}
