function  save_animation(mov,plot_step,str)
    v = VideoWriter(str,'MPEG-4');
    v.FrameRate=1/plot_step;
    open(v)
    writeVideo(v,mov)
    close(v)
end