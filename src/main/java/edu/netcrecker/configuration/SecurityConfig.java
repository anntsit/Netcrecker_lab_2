package edu.netcrecker.configuration;

import edu.netcrecker.service.CustomUserDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationTrustResolver;
import org.springframework.security.authentication.AuthenticationTrustResolverImpl;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.csrf.CsrfTokenRepository;
import org.springframework.security.web.csrf.HttpSessionCsrfTokenRepository;


@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Autowired
    @Qualifier("customUserDetailsService")
    CustomUserDetailsService authenticationService;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests().antMatchers("/", "home")
                .access("hasRole('ADMIN') or hasRole('USER') or hasRole('CUST')")
                .antMatchers("/newuser")
                .access("hasRole('ADMIN')")
                .antMatchers("/listProjects")
                .access("hasRole('ADMIN') or hasRole('USER') or hasRole('CUST')")
                .antMatchers("/edit-user-**")
                .access("hasRole('ADMIN') or hasRole('CUST')")
                .antMatchers("/delete-user-**")
                .access("hasRole('ADMIN')")
                .antMatchers("/newproject")
                .access("hasRole('ADMIN') or hasRole('CUST')")
                .antMatchers("/add-user-**")
                .access("hasRole('ADMIN') or hasRole('CUST')")
                .antMatchers("/edit-project-**")
                .access("hasRole('ADMIN') or hasRole('CUST')")
                .antMatchers("/get-all-user-**")
                .access("hasRole('ADMIN')  or hasRole('CUST')")
                .antMatchers("/delete-project-**")
                .access("hasRole('ADMIN')")
                .and().formLogin().loginPage("/login").loginProcessingUrl("/login").permitAll().and().logout().permitAll()
                .and().csrf().csrfTokenRepository(csrfTokenRepository());
    }

    @Autowired
    public void configureGlobalSecurity(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(authenticationService);
        auth.authenticationProvider(authenticationProvider());
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider();
        authenticationProvider.setUserDetailsService(authenticationService);
        authenticationProvider.setPasswordEncoder(passwordEncoder());
        return authenticationProvider;
    }

    @Bean
    public AuthenticationTrustResolver getAuthenticationTrustResolver() {
        return new AuthenticationTrustResolverImpl();
    }

    private CsrfTokenRepository csrfTokenRepository() {
        HttpSessionCsrfTokenRepository repository = new HttpSessionCsrfTokenRepository();
        repository.setSessionAttributeName("_csrf");
        return repository;
    }

}
